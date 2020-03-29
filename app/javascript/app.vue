<template>
  <div id="app">
    <Header msg="コンポーネントのヘッダ"></Header>
    <div id="nav">
    </div>
    <router-link to="/">Page1</router-link> |
    <router-link to="/page2">Page2</router-link>
    <router-view/>
    <Footer msg="コンポーネントのフッタ"></Footer>
  </div>
</template>

<script>
  import Header from './components/header.vue'
  import Footer from './components/footer.vue'

  export default {
    name: 'MyApp',
    props: {
      msg: String
    },
    components: {
      Header,
      Footer,
    }
  }
</script>

<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
  }
</style>