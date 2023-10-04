// Example using Axios
import React, { useState } from 'react'
import axios from 'axios';
import Twitterlikepost from './Twitterlikepost';

const apiUrl = 'http://54.152.181.77:30081/api'; // Replace with your .NET API URL




  function Post() {
    const [posters, setPosters] = useState([])





    const [textInput, setTextInput] = useState('');
    const [apiResponse, setApiResponse] = useState('');
  
    const handleInputChange = (event) => {
      setTextInput(event.target.value);
    };
  
    const handleApiCall = () => {
      // Make an API call using Axios
      const body = textInput;
      axios
        .post(`${apiUrl}/posters`,body, {
          headers: {
            'Content-Type': 'application/json',
          },
        })
        .then((response) => {
          console.log(response.data);
          setApiResponse(response.data.Message);
          setTextInput('')
        })
        .catch((error) => {
          console.error('Error making API call:', error);
        });
    };
    const handleEnter = (event) => {
      console.log(event)
      if(event.Key === "Enter"){
        handleApiCall()
      }
    }



    axios.get(`${apiUrl}/posters`)
    .then(response => {
      // Handle the API response data here 
      console.log(response)
      if(response.data.length !== posters.length){
        setPosters(response?.data)
      }
    })
    .catch(error => {
      // Handle errors
    });
    return (
      <div className="App">
        <header className="App-header">
           {posters?.map((post,index)=>{
            return (<div><Twitterlikepost time={post.date} username='User' tweetText={post.message} avatarUrl='https://user-images.githubusercontent.com/522079/90506845-e8420580-e122-11ea-82ca-31087fc8486c.png'></Twitterlikepost></div>)
           })}

        <div>

      <input
        type="text"
        placeholder="Enter text..."
        value={textInput}
        onChange={handleInputChange}
        onSubmit={handleApiCall}
        onKeyDown={handleEnter}
      />
      <button onClick={handleApiCall} >Send</button>
      {apiResponse && (
        <div>
          <h3>API Response:</h3>
          <p>{apiResponse}</p>
        </div>
      )}
    </div>
        </header>
      </div>
    );
  }
  
  export default Post;
  