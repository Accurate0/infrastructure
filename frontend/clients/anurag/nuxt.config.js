export default {
  ssr: false,
  target: 'static',
  generate: {
    fallback: '404.html',
    routes: ['/blog', '/projects', '/projects/website'],
  },

  head: {
    title: 'Anurag Singh',
    htmlAttrs: {
      lang: 'en',
    },
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
      { property: 'og:title', content: 'anurag singh' },
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.png' }],
  },

  server: {
    port: 3000,
    host: '0.0.0.0',
  },

  colorMode: {
    classSuffix: '',
  },

  windicss: {
    preflight: false,
  },

  css: ['~/assets/style'],
  plugins: [],
  components: true,
  buildModules: [
    '@nuxt/typescript-build',
    'nuxt-windicss',
    '@nuxtjs/color-mode',
  ],

  modules: ['@nuxt/content'],
  build: {},
}
