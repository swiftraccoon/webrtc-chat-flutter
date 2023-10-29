const Message = require('../models/messageModel');
const { encrypt, decrypt } = require('../utils/encryption');

exports.sendMessage = async (req, res) => {
    const { chatroomId, content } = req.body;
    const userId = req.user._id;

    const encryptedContent = encrypt(content);

    const message = await Message.create({
        chatroom: chatroomId,
        user: userId,
        content: encryptedContent
    });

    if (message) {
        res.status(201).json(message);
    } else {
        res.status(400).json({ message: 'Invalid message data' });
    }
};

exports.getMessages = async (req, res) => {
    const { chatroomId } = req.params;

    const messages = await Message.find({ chatroom: chatroomId }).sort('timestamp');

    if (messages) {
        const decryptedMessages = messages.map((msg) => {
            msg.content = decrypt(msg.content);  // Decrypt the message
            return msg;
        });

        if (messages) {
            res.status(200).json(decryptedMessages);
        } else {
            res.status(404).json({ message: 'No messages found' });
        }
    };
