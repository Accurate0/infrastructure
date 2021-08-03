import React from 'react';
import ReactDOM from 'react-dom';
import * as Sentry from '@sentry/react';
import { Integrations } from '@sentry/tracing';
import App from './App';
import reportWebVitals from './reportWebVitals';
import 'semantic-ui-less/semantic.less';

Sentry.init({
  enabled: process.env.NODE_ENV !== 'development',
  environment: process.env.NODE_ENV,
  dsn: 'https://ecb66ab96df441bdb455c1a2b758c09f@o931028.ingest.sentry.io/5879810',
  integrations: [new Integrations.BrowserTracing()],
});

ReactDOM.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
  document.getElementById('root')
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
