## 다중분류

D/T 장점: 해석 및 이해 용이, 수치,범주형 모두 사용가능.

​		단점: "과적합" 



hyper-parameter -> 과적합을 막아준다 ( 트리가 길어질수록 과적합이 일어나기 때문!)

- max_depth: 트리의 최대 깊이
- min_sample_split: 자식 노드를 갖기 위한 최소 데이터 개수
- min_samples_leaf: 리프노드의 최소 데이터 개수

