## kmeans

군집(cluster)의 개수를 지정해주고 군집의 개수만큼 랜덤한 위치에 포인트를 찍어준다.(b)

이 좌표를 기준으로 가까운 점들을 묶어주고 (c) ,다시 그 점들의 평균점들을 구해준다.(d)

![image-20210920200048740](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210920200048740.png)

다시 그 평균점을 기준으로 점들을 묶어주고(e) 평균점을 구해준다. 이 평균점들이 변하지 않을때까지 반복한다.(f)



이때 사용되는 거리를 구하는 방법으로는 대표적으로 유클리디안 거리, 맨하튼 거리가 있다.

![image-20210920200241711](C:/Users/NaEunSu/AppData/Roaming/Typora/typora-user-images/image-20210920200241711.png)

출처 : https://todayisbetterthanyesterday.tistory.com/58



