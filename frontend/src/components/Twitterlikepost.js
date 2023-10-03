import React, { useState } from 'react';
import "./Twitterlikepost.css"

function Twitterlikepost({ username, tweetText, avatarUrl, time }) {
  const [likes, setLikes] = useState(0);
  const [retweets, setRetweets] = useState(0);
  const [isLiked, setIsLiked] = useState(false);
  const [isRetweeted, setIsRetweeted] = useState(false);

  const handleLike = () => {
    if (isLiked) {
      setLikes(likes - 1);
    } else {
      setLikes(likes + 1);
    }
    setIsLiked(!isLiked);
  };

  const handleRetweet = () => {
    if (isRetweeted) {
      setRetweets(retweets - 1);
    } else {
      setRetweets(retweets + 1);
    }
    setIsRetweeted(!isRetweeted);
  };

  let diffTime = Math.floor((new Date(Date.now()) - new Date(time))/1000/60)

  return (
    <div className="twitter-post">
      <div className="user-avatar">
        <img src={avatarUrl} alt={`Avatar of ${username}`} />
      </div>
      <div className="post-content">
        <div className="user-info">
          <span className="username">{username}</span>
          <span className="post-date">{diffTime} minutes ago</span>
        </div>
        <p className="tweet-text">{tweetText}</p>
        <div className="post-actions">
          <div className={`action like ${isLiked ? 'active' : ''}`} onClick={handleLike}>
            <i className="far fa-heart"></i>
            <span>{likes}</span>
          </div>
          <div className={`action retweet ${isRetweeted ? 'active' : ''}`} onClick={handleRetweet}>
            <i className="fas fa-retweet"></i>
            <span>{retweets}</span>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Twitterlikepost;
