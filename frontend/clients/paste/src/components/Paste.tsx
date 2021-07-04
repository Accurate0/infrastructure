import { useState } from 'react';
import { useEffect } from 'react';
import { useLocation } from 'react-router';
import {
  Checkbox,
  Dimmer,
  Header,
  Loader,
  Menu,
  Message,
  Segment,
  Select,
} from 'semantic-ui-react';
import axios, { AxiosError } from 'axios';
import Highlight, { defaultProps, Language } from 'prism-react-renderer';
import vsDark from 'prism-react-renderer/themes/vsDark';
import { LanguageOptions } from './Languages';
import Countdown, { CountdownTimeDelta } from 'react-countdown';

interface IResponse {
  expire: number;
  paste: string;
  language?: Language;
  filename?: string;
}

const Paste = () => {
  const hash = useLocation().pathname.substring(1);
  const [data, setData] = useState<IResponse>();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<AxiosError>();
  const [linesOn, setLinesOn] = useState(false);
  const [lang, setLang] = useState<Language>('clike');
  const [expire, setExpire] = useState<number | undefined>();

  useEffect(() => {
    axios(`/api/${hash}`)
      .then((resp) => {
        setData(resp.data);
        setLang(resp.data.language);
        setExpire(resp.data.expire * 1000);
        setLoading(false);
      })
      .catch((e: Error | AxiosError) => {
        if (axios.isAxiosError(e)) {
          setError(e);
          setLoading(false);
        }
      });
  }, [hash]);

  const renderer = ({
    hours,
    minutes,
    seconds,
    completed,
  }: CountdownTimeDelta) => {
    if (completed) {
      return <span>Expired</span>;
    }
    return (
      <span>
        {hours}h{minutes}m{seconds}s
      </span>
    );
  };

  return (
    <>
      {error && (
        <Message negative>
          <Message.Header>{error.response?.statusText}</Message.Header>
        </Message>
      )}
      {loading ? (
        <Segment style={{ minHeight: 500 }}>
          <Dimmer active>
            <Loader size="large">Loading</Loader>
          </Dimmer>
        </Segment>
      ) : (
        data && (
          <>
            <Menu>
              {data?.filename && (
                <Menu.Item>
                  <Header>{data.filename}</Header>
                </Menu.Item>
              )}
              {expire && (
                <Menu.Item>
                  <Header>
                    <Countdown
                      date={Date.now() + expire}
                      renderer={renderer}
                      onTick={({ total }) => setExpire(total)}
                    />
                  </Header>
                </Menu.Item>
              )}
              <Menu.Menu position="right">
                <Menu.Item>
                  <Select
                    value={lang}
                    placeholder="Language"
                    options={LanguageOptions}
                    onChange={(_, data) => setLang(data.value as Language)}
                  />
                </Menu.Item>
                <Menu.Item>
                  <Header></Header>
                  <Checkbox
                    checked={linesOn}
                    toggle
                    onChange={() => setLinesOn(!linesOn)}
                  />
                </Menu.Item>
              </Menu.Menu>
            </Menu>
            <Highlight
              {...defaultProps}
              // Prism
              theme={vsDark}
              code={data.paste}
              language={lang ?? 'clike'}>
              {({ className, style, tokens, getLineProps, getTokenProps }) => (
                <pre
                  className={className}
                  style={{
                    ...style,
                    overflowX: 'auto',
                    wordBreak: 'normal',
                    wordWrap: 'normal',
                    whiteSpace: 'pre',
                    padding: 25,
                    color: '#C5C8C6',
                    borderRadius: 5,
                    margin: 0,
                  }}>
                  {tokens.map((line, i) => (
                    <div {...getLineProps({ line, key: i })}>
                      {linesOn && (
                        <span>
                          {i + 1}
                          {'  '}
                        </span>
                      )}
                      {line.map((token, key) => (
                        <span {...getTokenProps({ token, key })} />
                      ))}
                    </div>
                  ))}
                </pre>
              )}
            </Highlight>
          </>
        )
      )}
    </>
  );
};

export default Paste;
