import { promiseMiddleware } from './middleware';

const makeStore = (state = {}) => ({
  getState: () => ({ viewChangeCounter: 0, ...state }),
  dispatch: jest.fn()
});

test('promiseMiddleware does not crash when error.response is null (network error)', done => {
  const store = makeStore();
  const next = jest.fn();
  const middleware = promiseMiddleware(store)(next);

  const networkError = new Error('Network Error');
  networkError.response = null;

  const action = {
    type: 'APP_LOAD',
    payload: Promise.reject(networkError),
    skipTracking: true
  };

  middleware(action);

  // Give the promise rejection handler time to run
  setTimeout(() => {
    try {
      // If we get here without throwing, the bug is fixed.
      // store.dispatch should have been called (not crashed).
      expect(store.dispatch).toHaveBeenCalled();
      done();
    } catch (e) {
      done(e);
    }
  }, 50);
});
