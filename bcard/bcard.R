library(grid)
library(showtext)
library(purrr)

wid <- 3.5
hgt <- 2
res <- 300
mrg <- 0.25/2

phi <- (1+sqrt(5))/2
iphi <- 1/phi

src.split <- 3
src <- readLines("bcard.R") %>%
    (function(x) x[!grepl("^\\s*#", x)]) %>%
    paste0(collapse="\n") %>%
    (function (x) gsub("\n{3,}", "\n\n", x))
src <- strsplit(src, "\n")[[1]]
src <- sapply(1:src.split - 1, function(i) {
    n <- ceiling(length(src)/src.split)
    src[n*i + 1:n] %>% keep(~!is.na(.x)) %>% paste0(collapse="\n")
})


font.add('raleway-thin','Raleway-Thin.ttf')
font.add('raleway-extralight','Raleway-ExtraLight.ttf')
font.add('raleway-light','Raleway-Light.ttf')
font.add('raleway-regular','Raleway-Regular.ttf')

#font.add('josefinsans-thin','JosefinSans-Thin.ttf')
#font.add('josefinsans-light','JosefinSans-Light.ttf')
#font.add('josefinsans-reg','JosefinSans-Regular.ttf')

#font.add('josefinslab-thin','JosefinSlab-Thin.ttf')
#font.add('josefinslab-light','JosefinSlab-Light.ttf')
#font.add('josefinslab-reg','JosefinSlab-Regular.ttf')

#font.add('robotoslab-thin','RobotoSlab-Thin.ttf')
#font.add('robotoslab-light','RobotoSlab-Light.ttf')
#font.add('robotoslab-reg','RobotoSlab-Regular.ttf')

#font.add('cormorant-light','Cormorant Garamond 300.ttf')
#font.add('cormorant-reg','Cormorant Garamond regular.ttf')

font.add('consolas','Consolas.ttf')

showtext.auto()
showtext.opts(dpi = res)

u <- function(x) unit(x,'inches')
wid.u <- u(wid)
hgt.u <- u(hgt)
mrg.u <- u(mrg)

lh <- get.gpar()$lineheight
fss <- 8
fsb <- 16
fss.u <- unit(fss,unit='pt')
fsb.u <- unit(fsb,unit='pt')

font.reg <- 'raleway-extralight'
font.big <- 'raleway-light'

#font.reg <- 'josefinsans-light'
#font.big <- 'josefinsans-reg'

#font.reg <- 'josefinslab-light'
#font.big <- 'josefinslab-reg'

#font.reg <- 'robotoslab-light'
#font.big <- 'robotoslab-reg'

#font.reg <- 'cormorant-light'
#font.big <- 'cormorant-reg'

#bg.col <- '#ffffff'     # white
#bg.col <- '#fbfbf9'     # beige 5
#bg.col <- '#f2f1eb'     # beige 10
bg.col <- '#e9e6df'     # beige 20
#bg.col <- '#f3efd8'     # sandstone 20

#hil <- NA
hil <- '#820000'    # text red
#hil <- '#565347'    # warm gray 90
#hil <- '#53284F'    # deep red/purple

#name.col <- 'black'
#name.col <- '#820000'
name.col <- '#8c1515'

drawCard <- function(hil=NA,name.col='black') {
    grid.newpage()
    rect.bg <- rectGrob(x=unit(0,'npc'),width=unit(1,'npc'),
        y=unit(0,'npc'),height=unit(1,'npc'),
        just=c(0,0),gp=gpar(col=NA,fill=bg.col))
    lab.su <- textGrob('Stanford University',
        x=wid.u-mrg.u,y=hgt.u-mrg.u,
        just=c(1,1),
        gp=gpar(fontfamily=font.big,fontsize=fss))
    lab.gsb <- textGrob('Graduate School of Business',
        x=wid.u-mrg.u,y=hgt.u-mrg.u-1.2*fss.u,
        just=c(1,1),
        gp=gpar(fontfamily=font.reg,fontsize=fss))
    lab.add <- textGrob(paste0(c("1 (617) 610-1159",
                                 "vashevko@stanford.edu",
                                 "web.stanford.edu/~vashevko"),
                               collapse="\n"),
        x=wid.u-mrg.u,y=mrg.u,
        just=c(1,0),
        gp=gpar(fontfamily=font.reg,fontsize=fss,lineheight=1.0))
    rect.hil <- rectGrob(x=unit(0,'npc'),width=unit(1,'npc'),
        y=hgt.u*iphi+0.7*fsb.u,height=1.5*fsb.u+1.2*fss.u,
        just=c(0,1),gp=gpar(col=NA,fill=hil))

    name.col <- ifelse(is.na(hil),name.col,'white')

    lab.name <- textGrob('Anthony Vashevko',
        x=wid.u-mrg.u,y=hgt.u*iphi,
        just=c(1,0.5),
        gp=gpar(fontfamily=font.big, fontsize=fsb,
                lineheight=1.0, col=name.col))
    lab.ttl <- textGrob('Organizational Behavior',
        x=wid.u-mrg.u,y=hgt.u*iphi-0.5*1.6*fsb.u,
        just=c(1,1),
        gp=gpar(fontfamily=font.reg, fontsize=fss,
                lineheight=1.0, col=name.col))
    grid.draw(rect.bg)
    grid.draw(lab.su)
    grid.draw(lab.gsb)
    grid.draw(lab.add)
    if(!is.na(hil)) { grid.draw(rect.hil) }
    grid.draw(lab.name)
    grid.draw(lab.ttl)
}

drawBack <- function() {
    grid.newpage()
    rect.bg <- rectGrob(x=unit(0,'npc'),width=unit(1,'npc'),
        y=unit(0,'npc'),height=unit(1,'npc'),
        just=c(0,0),gp=gpar(col=NA,fill=bg.col))
    grid.draw(rect.bg)
}

drawSource <- function() {
    grid.newpage()
    rect.bg <- rectGrob(x=unit(0,'npc'),width=unit(1,'npc'),
        y=unit(0,'npc'),height=unit(1,'npc'),
        just=c(0,0),gp=gpar(col=NA,fill=bg.col))
    grid.draw(rect.bg)
    text.srcs <- lapply(1:src.split, function(i) {
        textGrob(src[i], just=c(0, 1), rot=0,
                 x=unit((i-1)/src.split, 'npc'), y=unit(0.995, 'npc'),
                 gp=gpar(fontfamily='consolas',
                         fontsize=2))
        })
    text.hgts <- sapply(text.srcs, function (x) heightDetails(x) %>% convertUnit(unitTo='pt'))
    for(tg in text.srcs) grid.draw(tg)
}

fname <- 'bcard-grid'
bname <- 'bcard-back'

pdf(paste0(fname,'.pdf'),width=wid,height=hgt)
drawCard(hil,name.col)
dev.off()

pdf(paste0(bname,'.pdf'),width=wid,height=hgt)
#drawBack()
drawSource()
dev.off()

#nup
system(paste0("pdfnup --papersize '{11in,17in}' -o ", fname,
              "-3x8.pdf --nup '3x8' --no-landscape ", fname,
              ".pdf '",paste0(rep(1,24),collapse=','), "'"))
system(paste0("pdfnup --papersize '{10.5in,16in}' -o ", fname,
              "-3x8s.pdf --nup '3x8' --no-landscape ", fname,
              ".pdf '",paste0(rep(1,24),collapse=','), "'"))

system(paste0("pdfnup --papersize '{11in,17in}' -o ", bname,
              "-3x8.pdf --nup '3x8' --no-landscape ", bname,
              ".pdf '",paste0(rep(1,24),collapse=','), "'"))
system(paste0("pdfnup --papersize '{10.5in,16in}' -o ", bname,
              "-3x8s.pdf --nup '3x8' --no-landscape ", bname,
              ".pdf '",paste0(rep(1,24),collapse=','), "'"))

system(paste0("pdfjoin --papersize '{11in,17in}' ", fname,
              "-3x8.pdf ",bname,"-3x8.pdf -o ", fname, "-join-3x8.pdf"))
system(paste0("pdfjoin --papersize '{10.5in,16in}' ", fname,
              "-3x8s.pdf ",bname,"-3x8s.pdf -o ", fname, "-join-3x8s.pdf"))

