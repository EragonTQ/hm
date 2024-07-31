import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { buffer, util } from '@kit.ArkTS';

const encode = 'utf-8'
function genIvParamsSpec() {
  let arr = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // 16 bytes
  let dataIv = new Uint8Array(arr);
  let ivBlob: cryptoFramework.DataBlob = { data: dataIv };
  let ivParamsSpec: cryptoFramework.IvParamsSpec = {
    algName: "IvParamsSpec",
    iv: ivBlob
  };
  return ivParamsSpec;
}

function stringTo16ByteArray(key:string): Uint8Array  {
  let textEn = new util.TextEncoder(encode);
  let buffer:ArrayBuffer = new ArrayBuffer(16);
  let encodeResult:Uint8Array = new Uint8Array(buffer);
  encodeResult = textEn.encodeInto(key)

  const test = textEn.encodeInto(key)
  return encodeResult;
}

export function getStrFromIntArray(byteArray:Uint8Array) : string{
  // 手动将字节数组转换为字符串
  let textDe = util.TextDecoder.create(encode,{ignoreBOM:true})
  let str =  textDe.decodeWithStream(byteArray,{stream:false})
  return str;
}

export  function genSymKeyByData(symKeyData: Uint8Array) {
  let symKeyBlob: cryptoFramework.DataBlob = { data: symKeyData };
  let aesGenerator = cryptoFramework.createSymKeyGenerator('AES128');
  let symKey =  aesGenerator.convertKeySync(symKeyBlob);
  console.info('convertKey success' + symKey.format + symKey.getEncoded().data);
  return symKey;
}

async function encryptText( msg: string, aesKey: string) {
  console.log('加密前：'+ msg)
  console.log('秘钥:'+ aesKey)
  let keyData= stringTo16ByteArray(aesKey)
  let symKey = genSymKeyByData(keyData);
  console.log('秘钥格式化:'+ symKey.format)
  let target: cryptoFramework.DataBlob = { data: new Uint8Array(buffer.from(msg,encode).buffer) }
  return await encryptMessagePromise(symKey,target )

}

async function encryptMessagePromise(symKey: cryptoFramework.SymKey, plainText: cryptoFramework.DataBlob) {
  let cipher = cryptoFramework.createCipher('AES128|CBC|PKCS7');
  let iv = genIvParamsSpec();
  await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, symKey, iv);
  let cipherData = await cipher.doFinal(plainText);

  let res = buffer.from(cipherData.data).toString('hex');
  return res
}

export default  encryptText