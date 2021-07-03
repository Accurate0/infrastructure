import { BrowserRouter as Router, Link, Route, Switch } from 'react-router-dom';
import Paste from './components/Paste';
import Home from './components/Home';
import { Container, Header, Segment } from 'semantic-ui-react';

const App = () => {
  return (
    <>
      <Router>
        <Container text style={{ paddingBlock: 15 }}>
          <Link to="/">
            <Header as="h1">pastebin but bad</Header>
          </Link>
          <Segment>
            <Switch>
              <Route exact path="/">
                <Home />
              </Route>
              <Route path="*">
                <Paste />
              </Route>
            </Switch>
          </Segment>
        </Container>
      </Router>
    </>
  );
};

export default App;
