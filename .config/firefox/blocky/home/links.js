// add links here :D
const links = [
    {
        command: "curl",
        title: "archwiki",
        link: "https://wiki.archlinux.org",
        icon: "https://upload.wikimedia.org/wikipedia/commons/a/a5/Archlinux-icon-crystal-64.svg",
    },
    {
        command: "curl",
        title: "youtube",
        link: "https://youtube.com",
        icon: "https://upload.wikimedia.org/wikipedia/commons/4/42/YouTube_icon_%282013-2017%29.png",
    },
    {
        command: "curl",
        title: "r/unixporn",
        link: "https://reddit.com/r/unixporn",
        icon: "https://styles.redditmedia.com/t5_2sx2i/styles/communityIcon_7fixeonxbxd41.png?width=256&s=1ecde8d0f7197fe3aa1b9d6eef5936f7401db607",
    },
    {
        command: "curl",
        title: "spotify web",
        link: "https://open.spotify.com",
        icon: "https://cdn-icons-png.flaticon.com/512/174/174872.png",
    }    
];

const hidrateWithLinks = () => {
    let list = document.getElementsByClassName('items')[0];

    if (links && links.length && links.length > 0) {
        let li, a, wrapper, ind, header, com, title, img;
        
        links.forEach(item => {
            li = document.createElement('li');
            li.className = 'item';

            a = document.createElement('a');
            a.className = 'item-content';
            a.href = item.link;
            a.target = '_blank';
            
            // div wrapper
            wrapper = document.createElement('div');
            
            // line start '$'
            ind = document.createElement('h2');
            ind.innerText = '$';

            // wrapper for header
            header = document.createElement('h2');
            header.className = 'item-header';
            
            // command & title
            com = document.createElement('b');
            title = document.createElement('span');
            com.innerText = item.command;
            title.innerText = ' ' + item.title;

            header.appendChild(com);
            header.appendChild(title);

            wrapper.appendChild(ind);
            wrapper.appendChild(header);
            
            a.appendChild(wrapper);
            
            if (item.icon != '') {
                img = document.createElement('img');
                img.src = item.icon;
                img.alt = item.title;

                a.appendChild(img);
            }

            li.appendChild(a);

            list.appendChild(li);
        });
    }
}

hidrateWithLinks();