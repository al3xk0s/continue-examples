import fetch from "node-fetch";

async function getRandomNames() : Promise<string[]> {
    const uri = 'https://names.drycodes.com/10';
    const response = await fetch(uri);
    return await response.json() as string[];
}

function getRandomName(names: string[]) {
    const index = Math.floor(Math.random() * 10000) % names.length;
    return names[index];
}

export async function getName() {
    const names = await getRandomNames();
    return getRandomName(names);
}

export function getPage(name: string, avatar: string) : string {
    return `<!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="style.css">
        <script defer src="script.js"></script>
        <title>${name}</title>
    </head>
    <body>    
        <div class="wrapper">
            <h1>${name}</h1>
            <div class="text name">
                Hi, i'm ${name}.
            </div>
            <div class="photo">            
                <div class="image-wrapper photo__image-wrapper">
                    <img src="${avatar}" class="image photo__image" alt="">
                </div>
                <div class="text photo__text">
                    This is my photo.
                </div>   
            </div>        
        </div>
    </body>
    </html>`;
}