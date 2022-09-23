const express = require('express');
const app = express();

const path = require('path')
const port = 8000

app.use(express.static('./'));

app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '/index.html'));
});
app.listen(port);
console.log(`server is sunning at\n http://localhost:${port}/`)