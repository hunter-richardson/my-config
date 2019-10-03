#!/usr/bin/fish

builtin printf '%s google.%s #forcesafesearch' (command dig +short forcesafesearch.google.com) {a{c,d,e,l,m,s,t,z},b{a,e,f,g,i,j,s,t,y},c{a,at,c,d,f,g,h,i,l,m,n,om,v,z},
                                                                                                d{e,j,k,m,z},e{e,s},f{i,j,m,r},g{a,e,f,g,l,m,p,r,y},h{n,r,t,u},i{e,o,q,s,t},
                                                                                                j{e,o},k{g,i,z},l{a,i,k,t,u,v},m{d,e,g,k,l,n,s,u,v,w},n{e,l,o,r,u},
                                                                                                p{l,n,s,t},r{o,s,u,w},s{c,e,h,i,k,m,n,o,t,r}, t{d,g,k,l,m,n,o,t},v{g,u},ws,
                                                                                                co.{ao,bw,c{k,r},i{d,l,n},jp,k{e,r},ls,m{a,z},nz,t{h,z},u{g,k,z},v{e,i},z{a,m,w}},
                                                                                                com.{a{f,g,i,r,u},b{d,h,n,o,r,z},c{o,u,y},do,e{c,g,t},g{h,i,t},hk,jm,k{h,w},l{b,c,y},
                                                                                                     m{m,t,x,y},n{a,f,g,i,p},om,p{a,e,g,h,k,r,y},qa,s{a,b,g,l,v},t{j,r,w},u{a,y},v{c,n}}} | sudo tee -a /etc/hosts

for i in strict.bing safe.duckduckgo
  for j in (command dig +short '%s.com' $i)
    builtin printf '%s %s.com #%s\n' $j (builtin printf '%s\n' $i | command tac -s. | builtin string replace . '') | sudo tee -a /etc/hosts
  end
end

