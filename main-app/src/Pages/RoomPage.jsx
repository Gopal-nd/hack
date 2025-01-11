import React from 'react'
import { useParams } from 'react-router-dom'
import { ZegoUIKitPrebuilt } from '@zegocloud/zego-uikit-prebuilt';
const RoomPage = () => {
  const {roomId} = useParams();
    const meeting = async(element) =>{
    const  appID =process.env.APPID;
    const serverSecret =process.env.SERVERSECRET;
     const kitToken =  ZegoUIKitPrebuilt.generateKitTokenForTest(appID, serverSecret, roomId,  Date.now().toString(),"gopal");

    const zc = ZegoUIKitPrebuilt.create(kitToken);
    zc.joinRoom({
      container:element,
      scenario:{

      mode:ZegoUIKitPrebuilt.OneONoneCall,
      },

    })
  }
  return (
    <div>
      <div ref={meeting}       style={{ width: '100vw', height: '100vh' }}/>
    </div>
  )
}

export default RoomPage;
