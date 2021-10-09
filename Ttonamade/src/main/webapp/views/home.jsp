<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Ttonamade</title>
</head>
<body>
	<!-- Navigation-->
	<c:import url="header.jsp" />
	<!-- Avatar -->
	<header class="py-5 bg-primary text-center">
		<div class="container d-flex align-items-center flex-column">
			<a href="/Ttonamade"><img class="border border-secondary border-5 rounded-circle m-5" src="/Ttonamade/img/Ttonamade.jpg"
				width=400px height=400px"></a>
			<h1 class="masthead-heading text-uppercase mb-0">✿welcome✿</h1>
			<div class="divider-custom divider-light">
					<i class="fas fa-star"></i>
				</div>
			</div>
			<p class="fs-4 mb-0">since 2021.10.10</p>
		</div>
	</header>
	<!-- Portfolio Section-->
	<section class="page-section portfolio" id="portfolio">
		<div class="container">
			<!-- Portfolio Section Heading-->
			<h2
				class="page-section-heading text-center text-uppercase text-secondary mb-0">best👍</h2>
			<!-- Icon Divider-->
			<div class="divider-custom">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>
			<!-- Portfolio Grid Items-->
			<div class="row justify-content-center">
				<!-- Portfolio Item 1-->
				<div class="col-md-6 col-lg-4 mb-5">
					<div class="portfolio-item mx-auto" data-bs-toggle="modal"
						data-bs-target="#portfolioModal1" onclick="location.href='/Ttonamade/prodList'">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div class="portfolio-item-caption-content text-center text-dark">
								<i class="fas fa-plus fa-3x" style="color:--bs-blue"></i>
							</div>
						</div>

						<img class="img-fluid" src="/Ttonamade/img/아몬드초코크림치즈구겔호프.jpg"
							alt="..." />
					</div>
				</div>
				<!-- Portfolio Item 2-->
				<div class="col-md-6 col-lg-4 mb-5">
					<div class="portfolio-item mx-auto" data-bs-toggle="modal"
						data-bs-target="#portfolioModal2"  onclick="location.href='/Ttonamade/prodList'">
						<div class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div class="portfolio-item-caption-content text-center text-dark">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="/Ttonamade/img/아메리칸쿠키2.jpg" alt="..." />
					</div>
				</div>
				<!-- Portfolio Item 3-->
				<div class="col-md-6 col-lg-4 mb-5">
					<div class="portfolio-item mx-auto" data-bs-toggle="modal"
						data-bs-target="#portfolioModal3" onclick="location.href='/Ttonamade/prodList'">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div class="portfolio-item-caption-content text-center text-dark">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="/Ttonamade/img/딸기잼도우넛.jpg" alt="..." />
					</div>
				</div>
				<!-- Portfolio Item 4-->
				<div class="col-md-6 col-lg-4 mb-5">
					<div class="portfolio-item mx-auto" data-bs-toggle="modal"
						data-bs-target="#portfolioModal4" onclick="location.href='/Ttonamade/prodList'">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div class="portfolio-item-caption-content text-center text-dark">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="/Ttonamade/img/파운드케이크.jpg" alt="..." />
					</div>
				</div>
				<!-- Portfolio Item 5-->
				<div class="col-md-6 col-lg-4 mb-5 mb-md-0">
					<div class="portfolio-item mx-auto" data-bs-toggle="modal"
						data-bs-target="#portfolioModal5" onclick="location.href='/Ttonamade/prodList'">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div class="portfolio-item-caption-content text-center text-dark">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="/Ttonamade/img/생일 아이스박스케이크.jpg"
							alt="..." />
					</div>
				</div>
				<!-- Portfolio Item 6-->
				<div class="col-md-6 col-lg-4">
					<div class="portfolio-item mx-auto" data-bs-toggle="modal"
						data-bs-target="#portfolioModal6" onclick="location.href='/Ttonamade/prodList'">
						<div
							class="portfolio-item-caption d-flex align-items-center justify-content-center h-100 w-100">
							<div class="portfolio-item-caption-content text-center text-dark">
								<i class="fas fa-plus fa-3x"></i>
							</div>
						</div>
						<img class="img-fluid" src="/Ttonamade/img/미니큐브파운드.jpg" alt="..." />
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- About Section-->
	<section class="page-section bg-primary text-dark mb-0 p-5" id="about">
		<div class="container">
			<!-- About Section Heading-->
			<h2 class="page-section-heading text-center text-uppercase text-dark">About</h2>
			<!-- Icon Divider-->
			<div class="divider-custom divider-light">
				<div class="divider-custom-line"></div>
				<div class="divider-custom-icon">
					<i class="fas fa-star"></i>
				</div>
				<div class="divider-custom-line"></div>
			</div>
			<!-- About Section Content-->
			<div class="row">
				<div class="col-lg-4 m-auto">
					<p class="lead">
						Thank you for finding Ttonamade.<br> We hope you have a great
						time with our desserts.<br> Please spend a special day with
						us and give us a warm heart as a gift.
					</p>
				</div>
			</div>
		</div>
	</section>
	<c:import url="footer.jsp" />
</body>
</html>