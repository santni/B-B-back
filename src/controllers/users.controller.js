const pool = require('../config/database.config');
const { verifyEmail, verifyCpf, verifyPassword } = require('../models/verify.functions');
const dayjs = require('dayjs');
const hash = require('bcrypt');
const { sign } = require('jsonwebtoken');
const crypto = require('crypto');

const getAllUsers = async(req, res) => {
    try {
        const users = await pool.query('SELECT * FROM users;');
        return users.rowCount > 0 ?
            res.status(200).send({ total: users.rowCount, users: users.rows }) :
            res.status(200).send({ message: 'Users not registered' });
    } catch(e) {
        console.log('Could not GET all users, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' });
    }
}

const getUserByEmail = async(req, res) => {
    try {
        const { email } = req.params;

        const user = await pool.query('SELECT * FROM users WHERE email=$1', [email]);
        return user.rowCount > 0 ?
            res.status(200).send( user.rows[0] ) :
            res.status(200).send({ message: 'User not found' });
    } catch(e) {
        console.log('Could not GET user by email, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' }); 
    }
}

const getUserByCPF = async(req, res) => {
    try {
        const { cpf } = req.params;

        const user = await pool.query('SELECT cpf FROM users WHERE cpf=$1', [cpf]);
        return user.rows[0] ? 
            res.status(200).send(true) :
            res.status(200).send(false);
    } catch(e) {
        console.log('Could not GET user by email, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' }); 
    }
}

const postUser = async(req, res) => {
    try {
        const { name, email, cpf, telephone, password, address } = req.body;

        if(name.length < 10) {
            return res.status(400).send({ message: 'short_name' });
        } else if(!verifyEmail(email)) {
            return res.status(400).send({ message: 'invalid_email' });
        } else if(!verifyCpf(cpf)) {
            return res.status(400).send({ message: 'invalid_cpf' });
        } else if(telephone.length < 11) {
            return res.status(400).send({ message: 'invalid_telephone' });
        } else if(!verifyPassword(password)) {
            return res.status(400).send({ message: 'invalid_password' });
        } else {
            await pool.query('INSERT INTO users(name, email, cpf, telephone, password, address) VALUES($1, $2, $3, $4, $5, $6);',
        [name, email, cpf, telephone, password, address]);
            return res.status(201).send({ message: 'user successfully registered' });
        }
    } catch(e) {
        console.log('Could not POST user, server error', e);
        return res.status(500).send({ message: 'Could not HTTP POST' });
    }
}

const putUser = async(req, res) => {
    try {
        const { email } = req.params;
        const { name, cpf, telephone, password, address } = req.body;

        const user = getUserByEmail(email);
        
        if(!user) {
            return res.status(404).send({ message: 'User not found' });
        }
        
        if(name.length < 10) {
            return res.status(400).send({ message: 'short_name' });
        } else if(!verifyEmail(email)) {
            return res.status(400).send({ message: 'invalid_email' });
        } else if(!verifyCpf(cpf)) {
            return res.status(400).send({ message: 'invalid_cpf' });
        } else if(telephone.length < 11) {
            return res.status(400).send({ message: 'invalid_telephone' });
        } else if(!verifyPassword(password)) {
            return res.status(400).send({ message: 'invalid_password' });
        } else {
            await pool.query('UPDATE users SET name=$1, email=$2, cpf=$3, telephone=$4, password=$5, address=$6 WHERE email=$2;',
        [name, email, cpf, telephone, password, address]);
            return res.status(200).send({ message: 'user successfully updated' });
        }
    } catch(e) {
        console.log('Could not PUT user, server error', e);
        return res.status(500).send({ message: 'Could not HTTP PUT' });
    }
}

const deleteUser = async(req, res) => {
    try {
        const { email } = req.params;

        const user = getUserByEmail(email);
        if(!user) {
            return res.status(404).send({ message: 'User not found' });
        } else {
            await pool.query('DELETE FROM users WHERE email=$1', [email]);
            return res.status(200).send({ message: 'user successfully deleted' });   
        }
    } catch(e) {
        console.log('Could not DELETE user, server error', e);
        return res.status(500).send({ message: 'Could not HTTP DELETE' });
    }
}

const loginUser = async(req, res) => {
    try {
        const { email, password } = req.body;
        const getUser = (await pool.query('SELECT * FROM users WHERE email=$1', [email])).rows;

        if(getUser.length == 0) {
            return res.status(500).send({ message: 'User not found' });
        }

        const token = sign({}, "d2093a95-ed12-46fb-9bb4-8c16d28e6013", {
            subject: userId,
            expiresIn: "5m",
          });
      
          // expirar o login depois de 14 dias e ser obrigado a logar novamente
          const expiresIn = dayjs().add(14, "day").unix();
          const generateToken = () => {
            return crypto.randomBytes(15).toString("hex");
          };
          const generatertoken = generateToken();
          const generateRefreshToken = await pool.query(
            "INSERT INTO rtoken (rtoken, expires, user_id) VALUES ($1, $2, $3) RETURNING *",
            [generatertoken, expiresIn, email]
          );
      
          return res.status(200).send({
            token,
            refreshToken: generateRefreshToken.rows[0].rtoken,
            user: user
          });

    } catch(e) {
        console.log('Could not GET user, server error', e);
        return res.status(500).send({ message: 'Could not HTTP GET' });
    }
}

async function refreshToken(req, res) {
    try {
      const { refreshToken } = req.body;
  
      const token = await pool.query('SELECT * FROM rtoken WHERE rtoken = $1', [refreshToken]);
  
      if (!token.rows[0]) {
        return res.status(404).send({ message: "Token inválido" });
      }
  
      const newToken = sign({}, 'ao6Al-mR50ruM4-vq231Vs-gO418uibMe', {
        subject: token.rows[0].token.toString(),
        expiresIn: '15m'
      });
  
      return res.status(200).send({ token: newToken, refreshToken: token.rows[0] });
    } catch (error) {
      return res.status(500).send({ message: "Erro ao realizar refresh", error: error.message });
    }
  };

  async function logOut (req, res) {
    try {
      const { refreshToken } = req.body;
  
      await pool.query('DELETE FROM rtoken WHERE rtoken = $1', [refreshToken]);
  
      return res.status(200).send({ message: "Usuário deslogado com sucesso" });
    }
    catch (error) {
      return res.status(500).send({ message: "Erro ao deslogar", error: error.message });
    }
  }

module.exports = { getAllUsers, getUserByEmail, getUserByCPF, postUser, putUser, deleteUser };