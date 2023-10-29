const User = require('../models/userModel');
const generateToken = require('../utils/generateToken');
const nodemailer = require('nodemailer');
const nodemailer = require('nodemailer');

const sendConfirmationEmail = async (email, token) => {
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASS
    }
  });

  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: email,
    subject: 'Email Confirmation',
    text: `Please confirm your email by clicking the following link: http://localhost:3000/confirm/${token}`
  };

  await transporter.sendMail(mailOptions);
};

exports.register = async (req, res) => {
  const { email, password } = req.body;

  const userExists = await User.findOne({ email });

  if (userExists) {
    return res.status(400).json({ message: 'User already exists' });
  }

  const user = await User.create({
    email,
    password
  });

  // Send confirmation email
  const transporter = nodemailer.createTransport({
    // Configure your email service here
  });

  const mailOptions = {
    // Configure your email options here
  };

  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    } else {
      console.log('Email sent: ' + info.response);
    }
  });

  if (user) {
    const token = generateToken(user._id);
    res.status(201).json({
      _id: user._id,
      email: user.email,
      token: token
    });
    await sendConfirmationEmail(email, token);
  } else {
    res.status(400).json({ message: 'Invalid user data' });
  }
};

exports.login = async (req, res) => {
  const { email, password } = req.body;

  const user = await User.findOne({ email });

  if (user && (await user.matchPassword(password))) {
    res.json({
      _id: user._id,
      email: user.email,
      token: generateToken(user._id)
    });
  } else {
    res.status(401).json({ message: 'Invalid email or password' });
  }
};
