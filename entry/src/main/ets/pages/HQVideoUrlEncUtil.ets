import encryptText from './CommonUtil'
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { buffer, util } from '@kit.ArkTS';
import text from '@ohos.graphics.text';
import { AES, RandomUtil } from '@yunkss/eftool'

const key = "DFA66B6D";

// async function encrptionSubUrl(url:string, aesKey: string) : Promise<string> {
//     let res = await encryptText(url, aesKey)
//     return res
// }


async function test() {
    //test
    const test1 = 'DFA66B6D';
    let textEn = new util.TextEncoder('utf-8');
    let buffer: ArrayBuffer = new ArrayBuffer(16);
    let encodeResult: Uint8Array = new Uint8Array(buffer);
    encodeResult = textEn.encodeInto(test1)

    const textDec = new util.TextDecoder()
    const str = textDec.decodeWithStream(encodeResult)
    // console.log(str)

    const aes = await  AES.generateAESKey128();
    console.error("是否成功:" + aes.getSuccess() + "消息===:" + aes.getMsg() + "密钥======:", aes.getDataRow());

    let iv = await RandomUtil.generateIV();
    try {
        let encode = await AES.encodeCBC128('测试CBC加密字符串Test!', aes.getDataRow(), iv.getDataRow());
        const test = encode.getDataRow();

        console.log(test);
    } catch (e) {
        console.log(e);
    }


}

async  function encrptionUrl(originUrl: string, uid: number, deviceId : string, resourceId: number) :Promise<string> {
    if (!deviceId) {
        deviceId = "iosdev";
    }
    await test()

    // let url = new URL(originUrl);
    let query = originUrl.substring(originUrl.indexOf('?')+1);
    let aesKey = "";

    if (query.includes("MtsHlsUriToken") && query.includes("&")) {
        let regx = /MtsHlsUriToken=.+&/;
        let match = query.match(regx);
        if (match) {
            aesKey = match[0].replace("MtsHlsUriToken=", "").replace("&", "");
        }
    } else if (query.startsWith("MtsHlsUriToken")) {
        aesKey = query.replace("MtsHlsUriToken=", "");
    } else {
        return originUrl;
    }

    if (aesKey.length >= 8) {
        aesKey = aesKey.substring(0, 8) + key;
    } else {
        aesKey = aesKey + key;
    }

    let subVulueCom = `${uid}_${deviceId}_${Date.now()}`;
    let subVulue = await encryptText(subVulueCom, aesKey)
    console.log('加密后：'+ subVulue)
    let resultsUrl = `${originUrl}_${subVulue}`;

    if (uid === 0) {
        throw new Error("user id 不能为空");
    }
    if (!deviceId) {
        throw new Error("device id 不能为空");
    }

    return resultsUrl;
}

export default encrptionUrl;