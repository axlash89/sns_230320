package com.sns.post.bo;

import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.comment.dao.CommentMapper;
import com.sns.common.FileManagerService;
import com.sns.like.dao.LikeMapper;
import com.sns.post.dao.PostRepository;
import com.sns.post.entity.PostEntity;

@Service
public class PostBO {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PostRepository postRepository;
	
	@Autowired
	private CommentMapper commentMapper;
	
	@Autowired
	private LikeMapper likeMapper;

	@Autowired
	private FileManagerService fileManager;

	public List<PostEntity> getPostList() {
		return postRepository.findAllByOrderByIdDesc();
	}

	public Integer addPost(int userId, String userLoginId, String content, MultipartFile file) {

		String imagePath = null;

		if (file != null) {
			imagePath = fileManager.saveFile(userLoginId, file);
		}

		PostEntity postEntity = postRepository
				.save(PostEntity.builder()
						.userId(userId)
						.content(content)
						.imagePath(imagePath)
						.build());

		return postEntity == null ? null : postEntity.getId();
	}
	
	
	public int deletePostByPostIdAndUserId(int postId, int userId) {
		
		//post, comment, like
		commentMapper.deleteCommentByPostId(postId);
		likeMapper.deleteLikeByPostId(postId);
		
		Optional<PostEntity> postOptional = postRepository.findById(postId);
		if (postOptional.isEmpty()) {
			logger.error("###[글 삭제] 삭제할 글 불러오기 에러. postId:{}", postId);
			return 0;
		} else {
			postOptional.ifPresent(s -> postRepository.delete(s));
			return 1;
		}
		
	}
	
	public List<PostEntity> getPostListByUserId(int userId) {
		return postRepository.findAllByUserIdOrderByIdDesc(userId);
	}

}
