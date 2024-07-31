
@Entry
@Component
export struct TabTest {
  // @State tabIndex: number = 0;
  @State tabList: Array<string> = ['Tab1', 'Tab2', 'Tab3'];
  @State tabList2: Array<string> = ['Tab1', 'Tab2', 'Tab3'];
  build() {
    Flex({direction:FlexDirection.Column}){
      Row(){
        Text('video')
      }
      .height(400).backgroundColor('#80000000')
      .width('100%')
      Row(){
        Tabs() {
          ForEach(this.tabList, (item: string, index) => {
            TabContent() {
              List() {
                ListItem() {
                  List({}) {
                    ListItem() {
                      Text('1').height(100)
                    }.width('100%').backgroundColor(Color.Yellow)
                    ListItem() {
                      Text('2').height(100)
                    }.width('100%').backgroundColor(Color.Yellow)
                    ListItem() {
                      Text('3').height(100)
                    }.width('100%').backgroundColor(Color.Yellow)

                  }
                  .lanes(2)
                  .alignListItem(ListItemAlign.Start)
                  .listDirection(Axis.Horizontal)

                }
                ListItem(){
                  Text(item)
                    .fontSize(50)
                }
                ListItem(){
                  Text(item)
                    .fontSize(50)
                }
              }
              .direction(Direction.Ltr)
            }
            .tabBar(item)
          })
        }
      }
      .height('auto')
      .flexShrink(1)
      .backgroundColor(Color.Red)
    }

  }
}