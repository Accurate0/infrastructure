import axios, { AxiosError } from 'axios';
import { useState } from 'react';
import { useHistory } from 'react-router';
import { DropdownProps, Form, Message, TextAreaProps } from 'semantic-ui-react';
import { LanguageOptions } from './Languages';

interface IFormState {
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

  const handleChange = (
    e: any,
    { name, value }: TextAreaProps | DropdownProps
  ) => {
    setState({ ...state, [name]: value });
  };

  return (
    <>
      {error && (
        <Message negative>
          <Message.Header>{error.response?.statusText}</Message.Header>
        </Message>
      )}
      <Form onSubmit={onSubmit}>
        <Form.TextArea
          error={
            pasteError && {
              content: 'Required',
              pointing: 'above',
            }
          }
          style={{ minHeight: 400 }}
          value={state.paste}
          label="Paste"
          name="paste"
          placeholder="Paste"
          onChange={handleChange}
        />
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
    </>
  );
};

export default Home;
