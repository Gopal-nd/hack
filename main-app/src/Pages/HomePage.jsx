
import { useState } from 'react';
import { useNavigate } from 'react-router-dom';

function HomePage() {
  const [value,setValue] = useState();
  const navigate = useNavigate();

  const handleClick = ()=>{
    if(!value){
      return
    }
    navigate(`/room/${value}`)
  }
  return (
<div>
    <input type={"text"} value={value} onChange={(e)=>setValue(e.target.value)} placeholder="enter the room code"/>
      <button onClick={handleClick}>Join</button>
    </div>  );

}

export default HomePage;
