
import './App.css';
import { Route, Routes } from 'react-router-dom';
import HomePage from './Pages/HomePage';
import RoomPage from './Pages/RoomPage';

function App() {
  return (
<div>
      <Routes>
        <Route path='/' element={<HomePage/>}/>

        <Route path='/room/:roomId' element={<RoomPage/>}/>
      </Routes>
    </div>  );

}

export default App;
