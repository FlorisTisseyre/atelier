import reducer from './home';
import { HOME_PAGE_LOADED, HOME_PAGE_UNLOADED } from '../constants/actionTypes';

test('HOME_PAGE_LOADED sets tags from payload[0].tags', () => {
  const action = {
    type: HOME_PAGE_LOADED,
    payload: [
      { tags: ['java', 'spring'] },
      { articles: [], articlesCount: 0 }
    ]
  };
  const state = reducer({}, action);
  expect(state.tags).toEqual(['java', 'spring']);
});

test('tags are empty after HOME_PAGE_UNLOADED then re-populated on next HOME_PAGE_LOADED', () => {
  const loadAction = {
    type: HOME_PAGE_LOADED,
    payload: [{ tags: ['java'] }, { articles: [], articlesCount: 0 }]
  };

  let state = reducer({}, loadAction);
  expect(state.tags).toEqual(['java']);

  state = reducer(state, { type: HOME_PAGE_UNLOADED });
  expect(state.tags).toBeUndefined();

  state = reducer(state, loadAction);
  expect(state.tags).toEqual(['java']);
});
