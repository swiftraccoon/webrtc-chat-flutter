const forge = require('node-forge');

const secretKey = forge.random.getBytesSync(32); // Replace with your own secret key
const iv = forge.random.getBytesSync(12); // Initialization Vector

const encrypt = (text) => {
  const cipher = forge.cipher.createCipher('AES-GCM', secretKey);
  cipher.start({ iv: iv });
  cipher.update(forge.util.createBuffer(text));
  cipher.finish();
  const encrypted = cipher.output;
  const tag = cipher.mode.tag;
  return forge.util.encode64(encrypted.getBytes() + tag.getBytes());
};

const decrypt = (encryptedBase64) => {
  const encryptedBytesWithTag = forge.util.decode64(encryptedBase64);
  const tag = encryptedBytesWithTag.slice(-16);
  const encryptedBytes = encryptedBytesWithTag.slice(0, -16);

  const decipher = forge.cipher.createDecipher('AES-GCM', secretKey);
  decipher.start({
    iv: iv,
    tag: forge.util.createBuffer(tag),
  });
  decipher.update(forge.util.createBuffer(encryptedBytes));
  decipher.finish();
  return decipher.output.toString();
};

module.exports = {
  encrypt,
  decrypt,
};
