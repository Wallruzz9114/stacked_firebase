import { https } from 'firebase-functions';

import {
  initializeApp,
  credential as _credential,
  firestore,
} from 'firebase-admin';
import serviceAccount from './compound-53007-firebase-adminsdk-v3wqo-36e95e9b2e.json';

initializeApp({
  credential: _credential.cert(serviceAccount),
});

var database = firestore();

export const helloWorld = https.onRequest((_, response) => {
  const postsRef = database.collection('posts');

  for (let index = 0; index < 100; index++) {
    var postListRef = postsRef.doc(`post-${index}`);
    postListRef.set({
      title: `Post User ${index}`,
      imageUrl: 'https://picsum.photos/300/300',
      userId: 'my-id',
    });
  }

  response.send('Hello from Firebase!');
});
