const pool = require('../config/database.config');

const getAvaliations = async(req, res) => {
    try {
        const { restaurant } = req.params;

        const avaliations = await pool.query('SELECT AVG(avaliations) FROM avaliations WHERE restaurantID = $1', 
        [restaurant]);

        return avaliations.rowCount > 0 ? 
            res.status(200).send(avaliations.rows) :
            res.status(200).send(false);
    } catch(e) {
        console.log('Could not GET http request');
        return res.status(500).send({ message: 'Could not GET http request' });
    }
}

const postAvaliations = async(req, res) => {
    try {
        const { user } = req.params;
        const { avaliation, restaurantID } = req.body;

        const restaurantdb = (await pool.query('SELECT * FROM restaurants WHERE id=$1',[restaurantID])).rows[0];

        if(typeof avaliation !== 'number') {
            return res.status(400).send({ message: 'invalid avaliation' });
        } else if(!restaurantdb) {
            return res.status(400).send({ message: 'invalid restaurant' });
        } else  {
            await pool.query('INSERT INTO avaliations(avaliation, restaurantid, useremail) VALUES($1,$2,$3)',
            [avaliation, restaurantID, user]);
            return res.status(201).send({ message: 'Review successfully submitted.' });
        }
    } catch(e) {
        console.log('Could not POST http request');
        return res.status(500).send({ message: 'Could not POST http request' });
    }
}

module.exports = { getAvaliations, postAvaliations };