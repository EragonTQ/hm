
@Entry
@Component
export struct ProgressTest {
  @State progress: number = 1200;
  @State progress2: number = 0;

  build() {
    Flex({
      wrap: FlexWrap.NoWrap,
      direction: FlexDirection.Row,
      alignItems: ItemAlign.Center,
      justifyContent: FlexAlign.Start,

    }) {
      Row() {
        Text('10:40')

      } .flexShrink(0)
      Stack(){
        Progress({ type: ProgressType.Linear, value: this.progress, total: 5000 })
          .backgroundColor(Color.Black)
      } .align(Alignment.Start)

      Text('30:00')
        .textOverflow({overflow:TextOverflow.Ellipsis})
        .flexShrink(0)

    }
    .height(40)
    .width('100%')
    .backgroundColor('10000000')
  }
}