//connect to room
var appId = '87By7Ck3mJSmn2Bjz3FlUpNU';
var roomId = '5648a9f400b0814da5103b68';
// 每个客户端自定义的 id
var clientId = 'USER'+Math.random().toString();
// 用来存储 realtimeObject
var rt;
// 用来存储创建好的 roomObject
var room;
// 监听是否服务器连接成功
var firstFlag = true;

//connet to the server
function boot(){
  console.log('Connecting...')
  rt = AV.realtime({
    appId: appId,
    clientId: clientId,
    secure: false
  });

  // 监听服务情况
  rt.on('reuse', function() {
    console.log('服务器正在重连，请耐心等待。。。');
  });

  // 监听错误
  rt.on('error', function() {
    console.log('连接遇到错误。。。');
  });

  rt.on('open', function() {
    firstFlag = false;
    console.log('服务器连接成功！');

    // 获得已有房间的实例
    rt.room(roomId, function(object) {

      // 判断服务器端是否存在这个 room，如果存在
      if (object) {
        //start touch
        // $(areaId).css('background-color','red')

        room = object;
        console.log('Entering the room...')
        // 当前用户加入这个房间
        room.join(function() {
          // 获取成员列表
          room.list(function(data) {
            console.log('当前 Conversation 的成员列表：', data);
            // 获取在线的 client（Ping 方法每次只能获取 20 个用户在线信息）
            rt.ping(data.slice(0, 20), function(list) {
              console.log('当前在线的成员列表：', list);
            });
            var l = data.length;
            // 如果超过 500 人，就踢掉一个。
            if (l > 490) {
              room.remove(data[30], function() {
                console.log('人数过多，踢掉： ', data[30]);
              });
            }
          });
        });
      }
    });
  });
}

boot();

//send Event to the server
function sendEvent(name,option) {
  // body...
  if (!firstFlag && room){
    room.send({
      name:name,
      option:option
    },function(data){
      //callback
    })
  }
  // console.log(name,option)
}

//catch Events
var areaId = "#touch"
$(areaId).on('mousedown',function(e){
  sendEvent('down',{
    x:e.pageX,
    y:e.pageY
  })
  return true
}).on('mouseup',function(e){
  sendEvent('up',{
    x:e.pageX,
    y:e.pageY
  })
  return true
}).on('touchstart',function(e){
  sendEvent('down',{
    x:e.originalEvent.touches[0].pageX,
    y:e.originalEvent.touches[0].pageY
  })
  return true
}).on('touchend',function(e){
  console.log(e)
  sendEvent('up',{
    x:e.originalEvent.changedTouches[0].pageX,
    y:e.originalEvent.changedTouches[0].pageY
  })
  return true
})