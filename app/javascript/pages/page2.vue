<template>
<div class="footer">
  <h1>{{ msg }}</h1>
  <div class="message">
    <h3>app/javascript/imagesのロゴ</h3>
    <img class="img" src="../images/logo.png" /><br>
    これはページ2です。<br>
    この中にスタイルをまとめて書いてね<br>
  </div>
  <router-link to="/">前のページへ</router-link>
</div>
</template>

<script>
  export default {
  name: 'page2',
  props: {
    msg: "ページ2"
  }
}
</script>

<style scoped lang="scss">
.footer{
  background: aliceblue;
}
.message{
  margin: 0.2em;
  margin: 1em;
  padding: 1em;
  background: #EFEFEF;
  border: solid darkred;
}
img{
  background-image: image-url('/cat.png');
}
</style>