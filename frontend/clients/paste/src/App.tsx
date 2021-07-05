import { BrowserRouter as Router, Link, Route, Switch } from 'react-router-dom';
import Paste from './pages/Paste';
import Index from './pages';
import { Header, Segment } from 'semantic-ui-react';

const App = () => {
  return (
    <>
      <Router>
        <Segment style={{ borderRadius: 0, backgroundColor: '#131314' }}>
          <Link to="/">
            <Header textAlign="center" as="h1">
              pastebin but bad
            </Header>
          </Link>
        </Segment>
        <Switch>
          <Route exact path="/">
            <Index />
          </Route>
          <Route path="*">
            <Paste />
          </Route>
        </Switch>
      </Router>
    </>
  );
};

export default App;
