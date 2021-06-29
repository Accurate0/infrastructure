<template>
  <div
    class="
      lowercase
      subpixel-antialiased
      flex
      gap-6
      flex-col
      items-center
      justify-center
      h-screen
    "
  >
    <div class="capitalize text-4xl md:text-7xl">Anurag Singh</div>
    <div class="md:text-2xl hidden md:block">software engineer</div>
    <div
      class="select-none flex text-center flex-col gap-3 text-2xl md:text-2xl"
    >
      <div>
        <nuxt-link to="/blog">blog</nuxt-link>
      </div>
      <div>
        <nuxt-link to="/projects">projects</nuxt-link>
      </div>
      <br />
      <div>
        <a href="mailto:contact@anurag.sh">email</a>
      </div>
      <div>
        <a href="https://github.com/Accurate0">github</a>
      </div>
      <div>
        <a href="https://www.linkedin.com/in/anurag-singh8/">linkedin</a>
      </div>
      <br />
      <div>
        <a @click="specialToggle()">theme</a>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  layout: 'index',

  methods: {
    specialToggle() {
      this.$colorMode.preference =
        this.$colorMode.preference === 'default' ? 'special' : 'default'
    },
  },
}
</script>
