C     NCLFORTSTART
      subroutine fy4r_geo(fgeo,foname,ColumnNumber,LineNumber)
      
      implicit none
      character*(*) foname,fgeo
      integer*4 ColumnNumber(2748,1092), LineNumber(2748,1092)

      real*8 temp_lat(2748,2748),temp_lon(2748,2748)
      real*4 lat(2748,1092),lon(2748,1092)
      real*8 temp(2)
      integer*4 ::i,j,k=0
C     NCLEND 
      open(11,file = fgeo,access= "direct",
     &   form="unformatted" ,recl = 16)
      
      do i=1,2748
        do j=1,2748
          k=k+1
          read(11,rec=k) temp
          temp_lat(i,j) = temp(2)
          temp_lon(i,j) = temp(1)
        end do
      end do
      close(41)

      do i = 1,2748
       do j = 1,1092
         if(ColumnNumber(i,j) .ne.-1)then
           lat(i,j) = SNGL(temp_lat(ColumnNumber(i,j),LineNumber(i,j)))
           lon(i,j) = SNGL(temp_lon(ColumnNumber(i,j),LineNumber(i,j)))
         else
           lat(i,j) = -999.0
           lon(i,j) = -999.0
         end if
       end do
      end do
      open(41, file=foname, access="direct",
     &   action="write", form="unformatted", recl=2748*1092*4)
      write(41,rec = 1) lon
      write(41,rec = 2) lat
      close(41)
      
      end
