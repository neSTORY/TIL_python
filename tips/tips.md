## 시계열 type 조건문

type이 시계열(timestamp)을 조건문에서 활용하고싶으면 이렇게 사용하면 된다.

type(df["일시"][0])==pd._libs.tslibs.timestamps.Timestamp
