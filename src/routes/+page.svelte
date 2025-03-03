<script>
    import { onMount } from 'svelte';
    
    // Game list data
    const games = [
      { id: 1, title: "Pet Simulator 99!", image: "https://tr.rbxcdn.com/180DAY-afec168ada46d3a38be10e5d747fe3d2/256/256/Image/Webp/noFilter" },
      { id: 2, title: "PETS GO! ✨ [10x Luck]", image: "https://tr.rbxcdn.com/180DAY-5cd6a2ce22d969a11ab02491166e0fa1/256/256/Image/Webp/noFilter" },
      { id: 3, title: "[🩸UPDATE 4.0🩸] Anime Vanguards", image: "https://tr.rbxcdn.com/180DAY-69f9ebef3a7d7bca730f235a08b8a504/512/512/Image/Webp/noFilter" },
      { id: 4, title: "[🏪UPDATE 19.5 + EVENT🔫] AA", image: "https://tr.rbxcdn.com/180DAY-05038c93946bee1fd17d6245c7ecc07b/512/512/Image/Webp/noFilter", selected: true },
    ];
    
    // Current selected game
    let selectedGame = games.find(game => game.selected) || games[0];
    
    // Handle game selection
    function selectGame(game) {
      selectedGame = game;
    }

    const cabinetImageUrl = "https://see2believeproductions.com/storage/images/arcadeframe2.png";
    
    // Simulate loading effect on mount
    onMount(() => {
      // Any initialization code here
    });
  </script>
  
  <div class="flex min-h-screen bg-gray-900 text-white overflow-hidden">
    <!-- Left side game selection panel -->
    <div class="w-64 bg-black border-r-2 border-yellow-500 flex flex-col p-2">
      <div class="mb-4 p-2 bg-[#222213] text-yellow rounded text-center font-bold">
        GAME SELECT
      </div>
      
      <div class="flex-1 overflow-y-auto space-y-4">
        {#each games as game}
          <button 
            class="w-full p-2 text-left border-2 rounded transition-all duration-200 flex items-center"
            class:border-yellow-400={selectedGame.id === game.id}
            class:bg-yellow-900={selectedGame.id === game.id}
            class:border-blue-800={selectedGame.id !== game.id}
            class:bg-blue-900={selectedGame.id !== game.id}
            class:hover:bg-yellow-800={true}
            on:click={() => selectGame(game)}
          >
            <div class="w-full text-sm font-bold overflow-hidden">
              {game.title}
            </div>
          </button>
        {/each}
      </div>
    </div>
    
    <!-- Right side game display area with the custom cabinet image -->
    <div class="flex-1 relative">
      <!-- Cabinet background image -->
      <div class="absolute inset-0 flex items-center justify-center">
        <img 
          src={cabinetImageUrl} 
          alt="Arcade Cabinet" 
          class="h-[800px] object-contain"
        />
      </div>
      
      <!-- Game screen positioned to fit inside the cabinet's screen area -->
      <div class="absolute inset-0 flex items-center justify-center mt-50">
        <!-- Position and size adjusted to fit within the cabinet screen area -->
        <div class="w-4/12 h-2/5 mt-8 relative">
          <!-- Game screen -->
           <button>
               <div class="absolute inset-0 flex items-center justify-center">
                   <img 
                   src={selectedGame.image} 
                   alt={selectedGame.title}
                   class="max-w-full max-h-full object-contain"
                   />
                </div>
            </button>
          
          <!-- Screen reflection overlay -->
          <div class="absolute inset-0 bg-gradient-to-br from-transparent via-transparent to-blue-500 opacity-20"></div>
        </div>
      </div>
      
    </div>
  </div>



  <div class="min-h-screen bg-gray-900">
    <!-- พื้นหลังเบลอ -->
    <div class="fixed inset-0 bg-no-repeat bg-cover bg-center" style="background-image: url('https://scontent.fbkk24-1.fna.fbcdn.net/v/t39.30808-6/435109919_419726317469455_5945108413196874873_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=127cfc&_nc_ohc=dPfxhdjSu0AQ7kNvgGahCOb&_nc_oc=Adj6c_YNBwSE-MCz5umLlQzF7jGX3mrIlZ0L0oZHo_QiUqB0qifN38FPG8iBATvoxCPAiNlsQkca6GZMyUuoIDDI&_nc_zt=23&_nc_ht=scontent.fbkk24-1.fna&_nc_gid=Abnkow3KlG8qDzx_Hkq8RpN&oh=00_AYD_8ECV3Tpn44J264q8hHusWlKzKjyZQnz-BjTg8lRZZw&oe=67CA220B'); filter: blur(7px); opacity: 0.10; z-index: -1;"></div>
    
    <!-- ส่วนหลัก -->
    <main class="container mx-auto px-4 py-8">
        <!-- ชื่อเกม -->
        <div class="text-center mb-12">
            <center>
                <img class="w-[500px]" src="https://m1r.ai/9/o0f4n.png" alt="" srcset="">
            </center>
        </div>

        <!-- การ์ดเมนู -->
        <div class="grid grid-cols-1 lg:grid-cols-4 gap-6 mb-12">
            <!-- ร้านค้า -->
            <div class="bg-[#222213] rounded-lg overflow-hidden border-yellow-500/20 shadow-lg">
                <center>
                    <div class="p-6">
                        <div class="w-65 h-65 relative">
                            <img src="https://tr.rbxcdn.com/180DAY-afec168ada46d3a38be10e5d747fe3d2/256/256/Image/Webp/noFilter" alt="Store Icon" class="absolute right-0 bottom-0">
                        </div>
                        <h3 class="text-2xl font-bold text-white py-2">Pet Simulator 99!</h3>
                    </div>
                </center>
            </div>

            <div class="bg-[#222213] rounded-lg overflow-hidden border-yellow-500/20 shadow-lg">
                <center>
                    <div class="p-6">
                        <div class="w-65 h-65 relative">
                            <img src="https://tr.rbxcdn.com/180DAY-5cd6a2ce22d969a11ab02491166e0fa1/256/256/Image/Webp/noFilter" alt="Store Icon" class="absolute right-0 bottom-0">
                        </div>
                        <h3 class="text-2xl font-bold text-white py-2">PETS GO! ✨ [10x Luck]</h3>
                    </div>
                </center>
            </div>

            <div class="bg-[#222213] rounded-lg overflow-hidden border-yellow-500/20 shadow-lg">
                <center>
                    <div class="p-6">
                        <div class="w-65 h-65 relative">
                            <img src="https://tr.rbxcdn.com/180DAY-69f9ebef3a7d7bca730f235a08b8a504/512/512/Image/Webp/noFilter" alt="Store Icon" class="absolute right-0 bottom-0">
                        </div>
                        <h3 class="text-2xl font-bold text-white py-2">[🩸UPDATE 4.0🩸] Anime Vanguards</h3>
                    </div>
                </center>
            </div>

            <div class="bg-[#222213] rounded-lg overflow-hidden border-yellow-500/20 shadow-lg">
                <center>
                    <div class="p-6">
                        <div class="w-65 h-65 relative">
                            <img src="https://tr.rbxcdn.com/180DAY-05038c93946bee1fd17d6245c7ecc07b/512/512/Image/Webp/noFilter" alt="Store Icon" class="absolute right-0 bottom-0">
                        </div>
                        <h3 class="text-2xl font-bold text-white py-2">[🏪UPDATE 19.5 + EVENT🔫] AA</h3>
                    </div>
                </center>
            </div>
        </div>

    </main>
</div>