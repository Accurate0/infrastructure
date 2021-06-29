<template>
  <div class="h-screen">
    <h1 class="text-7xl px-16 pt-16">{{ page.title }}</h1>
    <div class="px-16 pt-8">
      <nuxt-content :document="page" />
    </div>
  </div>
</template>

<script>
export default {
  async asyncData({ params, $content }) {
    const pathMatch = params.pathMatch.endsWith('/')
      ? params.pathMatch.slice(0, -1)
      : params.pathMatch
    const path = pathMatch.includes('/') ? pathMatch : `${pathMatch}/index`

    const page = await $content(path).fetch()
    return {
      page,
    }
  },
  data() {
    return {
      page: null,
    }
  },
}
</script>
