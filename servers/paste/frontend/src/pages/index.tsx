import axios, { AxiosError } from 'axios';
import { useState } from 'react';
import Dropzone from 'react-dropzone';
import { useHistory } from 'react-router';
import {
  Container,
  DropdownProps,
  Form,
  Input,
  InputProps,
  Message,
  Segment,
  TextAreaProps,
} from 'semantic-ui-react';
import { LanguageOptions } from '../utils/Languages';

interface IFormState {
  filename?: string;
  paste?: string;
  language?: string;
}

// form
const Home = () => {
  const [error, setError] = useState<AxiosError>();
  const [pasteError, setPasteError] = useState(false);
  const [state, setState] = useState<IFormState>({});
  const history = useHistory();

  const onSubmit = () => {
    if (!state.paste || state.paste?.trim().length === 0) {
      setPasteError(true);
      return;
    }

    const form = new FormData();
    form.append('paste', state.paste);
    if (state.language && state.language?.length !== 0) {
      form.append('language', state.language);
    }
    if (state.filename && state.filename?.length !== 0) {
      form.append('filename', state.filename);
    }

    axios({
      method: 'POST',
      url: '/api',
      data: form,
      headers: { 'Content-Type': 'multipart/form-data' },
    })
      .then((resp) => {
        const uid = resp.data.uid;
        history.push(`/${uid}`);
      })
      .catch((error: AxiosError) => setError(error));
  };

  const onDropFile = (files: any[]) => {
    files.forEach((file) => {
      const r = new FileReader();
      r.onload = (evt) => {
        setState({ ...state, paste: evt.target?.result as string });
      };
      r.readAsText(file);
    });
  };

  const handleChange = (
    e: any,
    { name, value }: TextAreaProps | DropdownProps | InputProps
  ) => {
    setState({ ...state, [name]: value });
  };

  return (
    <Container text>
      <Segment>
        {error && (
          <Message negative>
            <Message.Header>{error.response?.statusText}</Message.Header>
          </Message>
        )}
        <Form onSubmit={onSubmit}>
          <Form.Field
            control={Input}
            value={state.filename}
            label="Filename"
            name="filename"
            placeholder="filename"
            onChange={handleChange}
          />

          <Dropzone
            maxFiles={1}
            onDrop={(acceptedFiles) => onDropFile(acceptedFiles)}>
            {({ getRootProps }) => (
              <section>
                <div {...getRootProps()}>
                  <Form.TextArea
                    error={
                      pasteError && {
                        content: 'Required',
                        pointing: 'above',
                      }
                    }
                    style={{ minHeight: 400, fontFamily: 'monospace' }}
                    value={state.paste}
                    label="Paste"
                    name="paste"
                    onChange={handleChange}
                  />
                </div>
              </section>
            )}
          </Dropzone>
          <Form.Select
            clearable
            options={LanguageOptions}
            label={{
              children: 'Language',
            }}
            placeholder="Language"
            search
            name="language"
            value={state.language}
            onChange={handleChange}
          />
          <Form.Button content="Submit" />
        </Form>
      </Segment>
    </Container>
  );
};

export default Home;
