<template>
  <div class="flex gap-8 flex-col items-center justify-center h-screen">
    <div class="text-4xl lg:text-7xl subpixel-antialiased select-none">
      <nuxt-link style="color: #f9fafb" to="/">
        An error occurred: {{ error.statusCode }}
      </nuxt-link>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    error: {
      type: Object,
      default: null,
    },
  },
  head: {
    title: 'error',
  },
}
</script>
