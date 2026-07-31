// Not found middleware placeholder
module.exports = (req, res, next) => {
  res.status(404).json({ success: false, message: 'Resource Not Found' });
};
