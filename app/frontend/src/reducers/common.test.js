import reducer from './common';
import { ARTICLE_SUBMITTED } from '../constants/actionTypes';

test('ARTICLE_SUBMITTED does not crash when payload is a validation error', () => {
  const state = { appName: 'Conduit', token: null, viewChangeCounter: 0 };

  const action = {
    type: ARTICLE_SUBMITTED,
    error: true,
    payload: { errors: { description: ["can't be blank"] } }
  };

  expect(() => reducer(state, action)).not.toThrow();
});
