import { hilog } from '@kit.PerformanceAnalysisKit';
import testNapi from 'libentry.so';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { buffer } from '@kit.ArkTS';
import encrptionUrl from './HQVideoUrlEncUtil'
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = '加密';

  async testAes() {
    try {
      let url =
        "https://vod-oss-hqwx-video.hqwx.com/v/2024/04/18/f80b5647a23b45e9/84f813fef62d12c1-hd.m3u8?MtsHlsUriToken=YXR9Ak7NymuZKPkCaVUzf1D.RRAEeLka.9tg3u1Ai7Vd0kMqft2mYYLnCo7PC1TwbteqEkc30qF4ZrmfnhkbQFBRvuAe.zKcYzDCuDEXbUhyzZKMGv5qMmY6C7k6wbuSul3PlKekx-wyWHjyep3A8M1PGZqMCccP6e7NFCf46QDOC5KJWMZIc.i3yyhym9-.JefkM9tGfHPYoO5x5aays2-JFr-FWZASdvrEn3TaQ4JS7ZDc.9b-wNtda6pA-09y75-CDPVVdfQb4ABwVjPJZg=="
      let test = await encrptionUrl(url, 184327677, 'A65BFB08-9D58-451A-AC82-53A4394590DE', 11111)
      console.log(test)
      //   let keyData = new Uint8Array([83, 217, 231, 76, 28, 113, 23, 219, 250, 71, 209, 210, 205, 97, 32, 159]);
      //   let symKey = await genSymKeyByData(keyData);
      //   let message = "This is a test";
      //   let plainText: cryptoFramework.DataBlob = { data: new Uint8Array(buffer.from(message, 'utf-8').buffer) };
      //   let encryptText = await encryptMessagePromise(symKey, plainText);
      //   let decryptText = await decryptMessagePromise(symKey, encryptText);
      //   if (plainText.data.toString() === decryptText.data.toString()) {
      //     console.info('decrypt ok');
      //     console.info('decrypt plainText: ' + buffer.from(decryptText.data).toString('utf-8'));
      //   } else {
      //     console.error('decrypt failed');
      //   }
    } catch (error) {
      console.error(`AES CBC “${error}“, error code: ${error.code}`);
    }
  }
  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.testAes()
            hilog.info(0x0000, 'testTag', 'Test NAPI 2 + 3 = %{public}d', testNapi.add(2, 3));
          })

        Text('TabTest'){
        }
        .margin(20)
        .onClick(() => {
         router.pushUrl({
            url: 'pages/TabTest'
          })
        })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

}
