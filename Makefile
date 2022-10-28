# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fquist <fquist@student.42heilbronn.de>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/09/20 18:21:35 by fquist            #+#    #+#              #
#    Updated: 2022/01/11 15:46:17 by fquist           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		:= push_swap

CC			:= gcc
CFLAGS		:= -Wall -Wextra -Werror
################################################################################
# SRCS PUSH_SWAP
SRCS		:= 1_stack_utils.c 2_stack_utils2.c 3_find_min_max.c 4_init_struct.c \
			   1_swaps.c 2_pushs.c 3_rotates.c 4_rev_rotates.c mod_atoi.c \
			   parser.c 1_indexing.c 2_ranking.c get_lis.c 1_chunks.c \
			   2_small_chunks_utils.c smart_rotations.c 1_small_sorts.c \
			   2_big_sorts.c 3_big_sort_utils.c 4_insertion_utils.c main.c \
			   frees.c

LIBS		+= 0_libft/libft.a

BONUS_SRCS	:= 1_stack_utils.c 2_stack_utils2.c 4_init_struct.c \
			   1_swaps.c 2_pushs.c 3_rotates.c 4_rev_rotates.c mod_atoi.c \
			   parser.c 1_indexing.c 2_ranking.c checker.c 1_main.c frees.c

ODIR		:= obj
SDIR		:= .
################################################################################
OBJS				= $(addprefix $(ODIR)/, $(SRCS:.c=.o))
BONUS_OBJS			= $(addprefix $(ODIR)/, $(BONUS_SRCS:.c=.o))
INCLUDES	:= -I 0_libft/inc

# COLORS
LB   		= \033[0;36m
B			= \033[0;34m
G		    = \033[0;32m
R 			= \033[0;31m
Y  			= \033[0;33m
X		    = \033[m

# **************************************************************************** #
#	SYSTEM SPECIFIC SETTINGS							   					   #
# **************************************************************************** #

UNAME_S		:= $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	CFLAGS += -D LINUX -Wno-unused-result
endif

# **************************************************************************** #
#	RULES																	   #
# **************************************************************************** #

.PHONY: all $(NAME) header clean fclean re bonus debug release libft

all: libft $(NAME)

$(NAME): prep $(OBJS)
	@$(CC) $(CFLAGS) $(INCLUDES) $(OBJS) -o $(NAME) $(LIBS)
	@printf "%-54b %b" "$(G)Push_swap compiled successfully!" "$(G)[✓]$(X)\n"
	@printf "$(B)==================== $(LB)$(NAME)$(B) ====================$(X)\n"

$(ODIR)/%.o: */%.c
	@$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@
	@printf "%-61b %b" "$(B)compiling: $(LB)$@" "$(G)[✓]$(X)\n"

libft:
	@make -C 0_libft

bonus: libft prep $(BONUS_OBJS)
	@$(CC) $(CFLAGS) $(INCLUDES) $(BONUS_OBJS) -o checker $(LIBS)
	@printf "%-54b %b" "$(G)Push_swap bonus compiled successfully!" "$(G)[✓]$(X)\n"
	@printf "$(B)================= $(LB)$(NAME) bonus$(B) =================$(X)\n"

header:
	@printf "$(B)==================== $(LB)$(NAME)$(B) ====================$(X)\n"

prep:
	@mkdir -p $(ODIR)

clean:
	@$(RM) -r *.dSYM $(SDIR)/*.dSYM $(SDIR)/$(NAME) $(ODIR) checker
	@make clean -C 0_libft 
	@printf "%-54b %b" "$(R)push_swap cleaned!" "$(G)[✓]$(X)\n"
	@printf "%-54b %b" "$(R)libft cleaned!" "$(G)[✓]$(X)\n"

fclean: header clean
	@$(RM) $(NAME)
	@make fclean -C 0_libft
	@printf "%-54b %b" "$(R)push_swap fcleaned!" "$(G)[✓]$(X)\n"
	@printf "$(B)===================================================$(X)\n"

re: header fclean all

norm:
	@norminette -R CheckForbiddenSourceHeader */*.c | grep --color=always 'Error!\|Error:' || echo "$(G)Everything is OK!$(X)" >&1

libnorm:
	@norminette -R CheckForbiddenSourceHeader 0_libft/src/*/*.c | grep --color=always 'Error!\|Error:' || echo "$(G)Everything is OK!$(X)" >&1

debug: CFLAGS += -O0 -DDEBUG -g
debug: all

release: fclean
release: CFLAGS	+= -O2 -DNDEBUG
release: all

# Push_swap_visualizer needed.
mvisual500: all
	@python3 pyviz.py `ruby -e "puts (-249..250).to_a.shuffle.join(' ')"`

visual500:
	@python3 pyviz.py `ruby -e "puts (-249..251).to_a.shuffle.join(' ')"`
	
mvisual100: all
	@python3 pyviz.py `ruby -e "puts (-49..50).to_a.shuffle.join(' ')"`

visual100:
	@python3 pyviz.py `ruby -e "puts (-49..50).to_a.shuffle.join(' ')"`