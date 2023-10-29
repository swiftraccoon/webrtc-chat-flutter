const express = require('express');
const { createChatroom, joinChatroom } = require('../controllers/chatController');

const router = express.Router();

router.post('/create', createChatroom);
router.post('/join/:chatroomId', joinChatroom);

module.exports = router;
