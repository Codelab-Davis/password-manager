const express = require('express');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());

app.get('/', (req, res) => {
  res.send('backend is working');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});