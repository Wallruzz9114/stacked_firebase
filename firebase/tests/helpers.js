import {
  initializeTestApp,
  loadFirestoreRules,
  apps,
  assertSucceeds,
  assertFails,
} from '@firebase/testing';
import { readFileSync } from 'fs';

export async function setup(auth, data) {
  const projectId = `rules-spec-${Date.now()}`;

  const app = initializeTestApp({
    projectId,
    auth,
  });

  const db = app.firestore();

  // Apply the test rules so we can write documents
  await loadFirestoreRules({
    projectId,
    rules: readFileSync('firestore-test.rules', 'utf8'),
  });

  // write mock documents if any
  if (data) {
    for (const key in data) {
      const ref = db.doc(key); // This means the key should point directly to a document
      await ref.set(data[key]);
    }
  }

  // Apply the actual rules for the project
  await loadFirestoreRules({
    projectId,
    rules: readFileSync('firestore.rules', 'utf8'),
  });

  return db;
}

export async function teardown() {
  // Delete all apps currently running in the firebase simulated environment
  Promise.all(apps().map((app) => app.delete()));
}

// Add extensions onto the expect method
expect.extend({
  async toAllow(testPromise) {
    let pass = false;
    try {
      await assertSucceeds(testPromise);
      pass = true;
    } catch (error) {
      // log error to see which rules caused the test to fail
      console.log(error);
    }

    return {
      pass,
      message: () =>
        'Expected Firebase operation to be allowed, but it was denied',
    };
  },
});

expect.extend({
  async toDeny(testPromise) {
    let pass = false;
    try {
      await assertFails(testPromise);
      pass = true;
    } catch (error) {
      // log error to see which rules caused the test to fail
      console.log(error);
    }

    return {
      pass,
      message: () =>
        'Expected Firebase operation to be denied, but it was allowed',
    };
  },
});
