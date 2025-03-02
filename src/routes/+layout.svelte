<script>
	import "../app.css";
  import Navbar from "./Navbar.svelte";
  </script>

  <svelte:head>
    <title>TeamSky Logs</title>
  </svelte:head>

<div class="min-h-screen w-full font-['Inter']">
  <Navbar/>
	<slot />
</div>