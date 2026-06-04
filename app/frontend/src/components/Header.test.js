import React from 'react';
import renderer from 'react-test-renderer';
import { MemoryRouter } from 'react-router-dom';
import Header from './Header';

const currentUser = { username: 'john', image: 'http://example.com/pic.jpg' };

test('displays username exactly once when logged in', () => {
  const tree = renderer.create(
    <MemoryRouter>
      <Header appName="Conduit" currentUser={currentUser} />
    </MemoryRouter>
  ).toJSON();

  const html = JSON.stringify(tree);
  const matches = html.match(/"john"/g) || [];
  expect(matches.length).toBe(1);
});
