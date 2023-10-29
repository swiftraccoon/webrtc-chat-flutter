const Chatroom = require('../models/chatModel');

exports.createChatroom = async (req, res) => {
  const { name, description } = req.body;
  const userId = req.user._id;

  const chatroomExists = await Chatroom.findOne({ name });

  if (chatroomExists) {
    return res.status(400).json({ message: 'Chatroom already exists' });
  }

  const chatroom = await Chatroom.create({
    name,
    description,
    createdBy: userId,
    roles: [{ userId, role: 'admin' }]
  });

  if (chatroom) {
    res.status(201).json(chatroom);
  } else {
    res.status(400).json({ message: 'Invalid chatroom data' });
  }
};

exports.joinChatroom = async (req, res) => {
  const { chatroomId } = req.params;
  const userId = req.user._id;

  const chatroom = await Chatroom.findById(chatroomId);

  if (!chatroom) {
    return res.status(404).json({ message: 'Chatroom not found' });
  }

  const isMember = chatroom.roles.some((role) => role.userId.equals(userId));

  if (isMember) {
    return res.status(400).json({ message: 'You are already a member' });
  }

  chatroom.roles.push({ userId, role: 'member' });

  await chatroom.save();

  res.status(200).json({ message: 'Successfully joined the chatroom' });
};
