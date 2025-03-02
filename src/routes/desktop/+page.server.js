// import { BASE_API_URl } from "$env/static/private";
// import axios from "axios";
// import { redirect } from "@sveltejs/kit";

// export async function load({params, locals}) {
//     try {
//         const response = await axios.post(`${BASE_API_URl}/bot`,{
//             key:locals.user
//         })
//         console.log(locals.user);

//         if (!locals.user) {
//             redirect(302, "/login");
//         }
        
//         if (response.data || locals.user) {
//             return {
//                 data: response.data,
//                 user: locals.user
//             }
//         }
//     } catch (error) {
//         redirect(302, "/login");
//         console.log(error);
//     }
// }