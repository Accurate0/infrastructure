// @ts-expect-error
import Prism from 'prism-react-renderer/prism';
// @ts-expect-error
(typeof global !== 'undefined' ? global : window).Prism = Prism;
require('prismjs/components/prism-kotlin');
require('prismjs/components/prism-csharp');
require('prismjs/components/prism-regex');
require('prismjs/components/prism-rust');
require('prismjs/components/prism-brainfuck');

export const LanguageOptions: {
  key: string;
  value: string;
  text: string;
}[] = [
  { key: 'markup', value: 'markup', text: 'markup' },
  { key: 'bash', value: 'bash', text: 'bash' },
  { key: 'clike', value: 'clike', text: 'clike' },
  { key: 'c', value: 'c', text: 'c' },
  { key: 'cpp', value: 'cpp', text: 'cpp' },
  { key: 'css', value: 'css', text: 'css' },
  { key: 'javascript', value: 'javascript', text: 'javascript' },
  { key: 'jsx', value: 'jsx', text: 'jsx' },
  { key: 'coffeescript', value: 'coffeescript', text: 'coffeescript' },
  { key: 'actionscript', value: 'actionscript', text: 'actionscript' },
  { key: 'diff', value: 'diff', text: 'diff' },
  { key: 'git', value: 'git', text: 'git' },
  { key: 'go', value: 'go', text: 'go' },
  { key: 'graphql', value: 'graphql', text: 'graphql' },
  { key: 'handlebars', value: 'handlebars', text: 'handlebars' },
  { key: 'json', value: 'json', text: 'json' },
  { key: 'less', value: 'less', text: 'less' },
  { key: 'makefile', value: 'makefile', text: 'makefile' },
  { key: 'markdown', value: 'markdown', text: 'markdown' },
  { key: 'objectivec', value: 'objectivec', text: 'objectivec' },
  { key: 'ocaml', value: 'ocaml', text: 'ocaml' },
  { key: 'python', value: 'python', text: 'python' },
  { key: 'reason', value: 'reason', text: 'reason' },
  { key: 'sass', value: 'sass', text: 'sass' },
  { key: 'scss', value: 'scss', text: 'scss' },
  { key: 'sql', value: 'sql', text: 'sql' },
  { key: 'stylus', value: 'stylus', text: 'stylus' },
  { key: 'tsx', value: 'tsx', text: 'tsx' },
  { key: 'typescript', value: 'typescript', text: 'typescript' },
  { key: 'wasm', value: 'wasm', text: 'wasm' },
  { key: 'yaml', value: 'yaml', text: 'yaml' },
  { key: 'csharp', value: 'csharp', text: 'csharp' },
  { key: 'kotlin', value: 'kotlin', text: 'kotlin' },
  { key: 'regex', value: 'regex', text: 'regex' },
  { key: 'rust', value: 'rust', text: 'rust' },
  { key: 'brainfuck', value: 'brainfuck', text: 'brainfuck' },
];
