const express = require('express');
const path = require('path');
const app = express();

const port = process.env.PORT || 3000;

// Serve static files from the 'public' directory
app.use(express.static(path.join(__dirname, 'html')));

// Route to return the current time in bold
app.get('/time', (req, res) => {
    const currentTime = new Date().toLocaleString();
    res.json({ currentTime: `<b>${currentTime}</b>` });
  });


// Start the server
const start = async () => {
    try {
      app.listen(port, () => console.log(`Server is listening port ${port}...`));
    } catch (error) {
      console.log(error);
    }
  };
  
  start();