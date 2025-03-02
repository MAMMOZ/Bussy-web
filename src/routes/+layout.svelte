<script>
	import "../app.css";
  import Navbar from "./Navbar.svelte";
  </script>

  <svelte:head>
    <title>Buszysky Pet Sim 99</title>
  </svelte:head>

<div class="min-h-screen w-full">
  <Navbar/>
	<slot />
</div>